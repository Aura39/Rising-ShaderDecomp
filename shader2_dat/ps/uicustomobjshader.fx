float2 g_GridScale;
sampler g_Sampler0;
sampler g_Sampler1;
sampler g_Sampler2;

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float2 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float4 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
	float3 texcoord5 : TEXCOORD5;
	float2 texcoord6 : TEXCOORD6;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	r0 = tex2D(g_Sampler0, i.texcoord);
	r0.xy = r0.yz * i.texcoord4.xx + i.texcoord4.yy;
	r0.xy = r0.xy + i.texcoord4.zz;
	r1 = i.texcoord2;
	r0.z = r0.w * r1.w + i.texcoord3.w;
	r2.yz = r0.zz * r0.xy;
	r3 = tex2D(g_Sampler0, i.texcoord6);
	r0.x = r3.x * i.texcoord4.x + i.texcoord4.y;
	r0.x = r0.x + i.texcoord4.z;
	r3.x = r3.w * r1.w + i.texcoord3.w;
	r0.w = r0.w + r3.w;
	r0.w = r0.w * 0.5;
	r3.y = r0.x * r3.x + r2.y;
	r2.x = r0.x * r3.x;
	r0.x = r0.y * r0.z + r3.y;
	r0.xy = r0.xw * i.texcoord4.yx;
	r0.x = r0.x * 0.33333334 + r0.y;
	r2.w = r0.w * i.texcoord4.z + r0.x;
	r0 = r2 * r1 + i.texcoord3;
	r1 = tex2D(g_Sampler1, i.texcoord1);
	r0.w = r0.w * r1.w;
	o.xyz = r0.xyz;
	r0.x = 1 / i.texcoord5.z;
	r0.xy = i.texcoord5.xy * r0.xx + 1;
	r0.xy = r0.xy * g_GridScale.xy;
	r0.xy = r0.xy * 0.5;
	r1 = tex2D(g_Sampler2, r0);
	o.w = r0.w * r1.w;

	return o;
}
