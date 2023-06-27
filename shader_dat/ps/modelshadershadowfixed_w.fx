float ems_bias;
float ems_bleed;
float3 fog;
float fogfar;
float fognear;
sampler g_Sampler0;
sampler g_Sampler1;
float4x4 g_ShadowViewProj;
float psType;

struct PS_IN
{
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float4 texcoord3 : TEXCOORD3;
	float3 texcoord5 : TEXCOORD5;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float4 r4;
	float4 r5;
	float4 r6;
	float4 r7;
	r0 = -0.0001 + i.texcoord1.w;
	r1.x = abs(psType.x);
	r1.y = (-r1.x >= 0) ? 1 : 0;
	r2 = r0.w * r1.y;
	clip(r0);
	clip(r2);
	r0.x = 1 / i.texcoord1.w;
	r0.yz = i.texcoord1.xy * r0.xx + 1;
	r1.zw = r1.yy * r0.yz;
	r2 = r1.z;
	r3 = r1.w;
	clip(r3);
	clip(r2);
	r1.zw = i.texcoord1.xy * -r0.xx + 1;
	r2.xy = r0.xx * i.texcoord1.xy;
	r0.xw = r1.yy * r1.zw;
	r3 = r0.x;
	r4 = r0.w;
	clip(r4);
	clip(r3);
	r0.x = (-i.texcoord3.z >= 0) ? 0 : 1;
	r2.zw = r2.xy * float2(-0.0001, 0.5) + 0.5;
	r2.xy = r2.xw * float2(0.5, 1) + float2(0.5, 0);
	r2.zw = r2.zw + 0.00048828125;
	r3 = tex2D(g_Sampler1, r2.zwzw);
	r4 = tex2D(g_Sampler0, r2.zwzw);
	r0.w = r4.x + -10;
	r2.z = dot(i.texcoord2.xyz, i.texcoord2.xyz);
	r2.z = 1 / sqrt(r2.z);
	r2.z = 1 / r2.z;
	r2.w = 1 / i.texcoord2.w;
	r2.zw = r2.zz * -r2.ww + float2(1, 0);
	r3.y = -r3.x + r2.z;
	r3.x = r3.x + 0.001;
	r0.x = (r3.y >= 0) ? r0.x : 0;
	r3.y = r0.x * r1.y;
	r4 = r3.y * -0.1;
	clip(r4);
	r4 = r2.xyxy + float4(0.0014648438, 0.00048828125, -0.00048828125, 0.00048828125);
	r5 = r2.xyxy + float4(0.00048828125, 0.0014648438, 0.00048828125, -0.00048828125);
	r6 = tex2D(g_Sampler1, r4);
	r4 = tex2D(g_Sampler1, r4.zwzw);
	r2.x = -r2.z + r4.x;
	r2.y = -r2.z + r6.x;
	r3.yz = (r2.yy >= 0) ? 0.25 : float2(0.25, 0);
	r2.x = (r2.x >= 0) ? r3.z : r3.y;
	r2.y = r2.x + 0.25;
	r4 = tex2D(g_Sampler1, r5);
	r5 = tex2D(g_Sampler1, r5.zwzw);
	r3.y = -r2.z + r5.x;
	r2.z = -r2.z + r4.x;
	r2.x = (r2.z >= 0) ? r2.y : r2.x;
	r2.y = r2.x + 0.25;
	r2.x = (r3.y >= 0) ? r2.y : r2.x;
	r2.x = r2.x + -0.35;
	r0.x = (-r0.x >= 0) ? r2.x : -0.35;
	r4.w = (i.texcoord3.z >= 0) ? r0.x : 0.65;
	r5 = r1.y * r4.w;
	clip(r5);
	r5 = r0.y;
	r6 = r0.z;
	clip(r6);
	clip(r5);
	r5 = r1.z;
	r6 = r1.w;
	clip(r6);
	clip(r5);
	r5 = i.texcoord5.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);
	r0.x = dot(r5, transpose(g_ShadowViewProj)[3]);
	r0.x = 1 / r0.x;
	r2.x = dot(r5, transpose(g_ShadowViewProj)[0]);
	r2.y = dot(r5, transpose(g_ShadowViewProj)[1]);
	r0.xy = r0.xx * r2.xy;
	r0.xy = r0.xy * float2(0.5, -0.5) + 0.5;
	r0.xy = r0.xy * 1024;
	r1.yz = frac(r0.xy);
	r0.xy = r0.xy + -r1.yz;
	r2.xy = r0.xy + float2(0, 1);
	r2.xy = r2.xy * 0.0009765625;
	r5 = tex2D(g_Sampler1, r2);
	r2.xy = r0.xy * 0.0009765625;
	r6 = r0.xyxy + float4(1, 0, 1, 1);
	r6 = r6 * 0.0009765625;
	r7 = tex2D(g_Sampler1, r2);
	r0.x = lerp(r5.x, r7.x, r1.z);
	r5 = tex2D(g_Sampler1, r6);
	r6 = tex2D(g_Sampler1, r6.zwzw);
	r0.y = lerp(r6.x, r5.x, r1.z);
	r2.x = lerp(r0.y, r0.x, r1.y);
	r0.x = -r3.x + r2.x;
	r0.y = -r2.x + r2.w;
	r0.y = r0.y * ems_bleed.x;
	r0.y = r0.y * 1.442695;
	r0.y = exp2(r0.y);
	r0.y = -r0.y + ems_bias.x;
	r0.y = r0.y + -0.3;
	r2.w = max(r0.y, 0);
	r0.x = r0.x + 0.1;
	r0 = (r0.x >= 0) ? 0 : r0.w;
	clip(r0);
	r0.x = fogfar.x;
	r0.x = r0.x + -fognear.x;
	r0.x = 1 / r0.x;
	r0.y = fogfar.x + i.texcoord3.w;
	r0.x = r0.x * r0.y;
	r0.y = r0.x + fog.x;
	r0.x = r0.x * fog.x;
	r2.x = r0.x * 1E-05;
	r4.x = r0.y * 1E-06;
	r4.yz = 0;
	r2.yz = 0;
	o = (-r1.x >= 0) ? r4 : r2;

	return o;
}
