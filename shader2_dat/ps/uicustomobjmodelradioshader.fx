float4 g_Color;
float2 g_LineRate;
float2 g_OverlayPower;
sampler g_Sampler0;
sampler g_Sampler1;
sampler g_Sampler2;

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float2 texcoord1 : TEXCOORD1;
	float3 texcoord2 : TEXCOORD2;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float4 r4;
	r0.x = 1 / i.texcoord2.z;
	r0.xy = i.texcoord2.xy * r0.xx + 1;
	r0.xy = r0.xy * g_LineRate.xy;
	r0.xy = r0.xy * 0.5;
	r1 = tex2D(g_Sampler1, r0);
	r0 = tex2D(g_Sampler2, r0);
	r0.xyz = r1.xyz * -r1.www + 1;
	r1.xyz = r1.www * r1.xyz;
	r2 = tex2D(g_Sampler0, i.texcoord1);
	r1.w = -r2.x + 1;
	r1.w = r1.w + r1.w;
	r0.x = r1.w * -r0.x + 1;
	r1.w = dot(r2.x, r1.x) + 0;
	r2.x = r2.x + -0.5;
	r2.x = (r2.x >= 0) ? r0.x : r1.w;
	r3 = tex2D(g_Sampler0, i.texcoord);
	r4.xyz = -r3.yzz + float3(1, 1, 0.9);
	r4.xy = r4.xy + r4.xy;
	r0.x = (r4.z >= 0) ? -0 : -1;
	r0.yz = r4.xy * -r0.yz + 1;
	r1.w = dot(r3.y, r1.y) + 0;
	r4 = r3.yzxy + float4(-0.5, -0.5, -0.1, -0.1);
	r2.y = (r4.x >= 0) ? r0.y : r1.w;
	r0.y = dot(r3.z, r1.z) + 0;
	r2.z = (r4.y >= 0) ? r0.z : r0.y;
	r1.xyz = r1.xyz * g_OverlayPower.xxx + r2.xyz;
	r1.xyz = r0.www * -g_OverlayPower.yyy + r1.xyz;
	r0.x = (r4.w >= 0) ? -0 : r0.x;
	r0.x = (r4.z >= 0) ? -0 : r0.x;
	r1.w = (r0.x >= 0) ? r3.w : 0;
	o = r1 * g_Color;

	return o;
}
