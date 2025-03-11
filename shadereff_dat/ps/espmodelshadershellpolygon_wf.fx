float4 g_CommonParam : register(c185);
float4 g_MatrialColor : register(c184);
sampler g_Sampler0 : register(s0);
float4 g_UvParam0 : register(c186);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float3 texcoord2 : TEXCOORD2;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0.x = -g_CommonParam.y;
	r1.xyz = normalize(-i.texcoord2.xyz);
	r0.y = dot(r1.xyz, i.texcoord1.xyz);
	r0.xy = -r0.xy + 1;
	r0.z = abs(g_CommonParam.y);
	r0.w = (-r0.z >= 0) ? 0 : 1;
	r0.z = 1 / r0.z;
	r1 = r0.y * -r0.w + r0.x;
	clip(r1);
	r0.x = g_CommonParam.y;
	r2 = r0.y * r0.w + -r0.x;
	r0.x = (-r0.x >= 0) ? r1.w : r2.w;
	clip(r2);
	r0.x = r0.z * r0.x;
	r0.yz = i.texcoord.xy * g_UvParam0.xy + g_UvParam0.zw;
	r1 = tex2D(g_Sampler0, r0.yzzw);
	r1.w = r0.x * r1.w;
	r0 = r1 * g_MatrialColor;
	r2.w = g_MatrialColor.w;
	r1 = r1.w * r2.w + -0.01;
	clip(r1);
	o = r0;

	return o;
}
