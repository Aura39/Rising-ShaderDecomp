float4 g_LuminanceRate : register(c186);
float4 g_MatrialColor : register(c184);
float4 g_Rate : register(c185);
sampler g_Sampler0 : register(s0);
sampler g_Sampler1 : register(s1);
sampler g_Sampler2 : register(s2);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float3 r2;
	r0.x = 1 / i.texcoord1.w;
	r0.xy = r0.xx * i.texcoord1.xy;
	r0.xy = r0.xy * float2(0.5, -0.5) + 0.5;
	r1 = tex2D(g_Sampler0, i.texcoord);
	r0.zw = r1.xy + g_Rate.zw;
	r0.xy = r0.zw * g_Rate.xy + r0.xy;
	r0 = tex2D(g_Sampler1, r0);
	r2.xyz = r0.xyz * -g_MatrialColor.xyz + r1.xyz;
	r0.xyz = r0.xyz * g_MatrialColor.xyz;
	r0.w = dot(r1.xyz, 0.298912);
	r0.w = r0.w * g_LuminanceRate.x;
	o.xyz = r0.www * r2.xyz + r0.xyz;
	r0 = tex2D(g_Sampler2, i.texcoord);
	o.w = r0.w * g_MatrialColor.w;

	return o;
}
