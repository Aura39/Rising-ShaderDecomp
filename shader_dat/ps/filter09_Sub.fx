sampler g_SamplerTexture : register(s0);
float4 g_TargetUvParam : register(c194);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	r0 = tex2D(g_SamplerTexture, texcoord);
	r0.x = dot(r0.xyz, 0.2126);
	r1.x = 2;
	r2.zw = g_TargetUvParam.xy * -r1.xx + texcoord.xy;
	r3 = tex2D(g_SamplerTexture, r2.zwzw);
	r3.z = dot(r3.xyz, 0.2126);
	r2.xy = g_TargetUvParam.xy * r1.xx + texcoord.xy;
	r1 = tex2D(g_SamplerTexture, r2);
	r3.w = dot(r1.xyz, 0.2126);
	r1 = tex2D(g_SamplerTexture, r2.xwzw);
	r2 = tex2D(g_SamplerTexture, r2.zyzw);
	r3.y = dot(r2.xyz, 0.2126);
	r3.x = dot(r1.xyz, 0.2126);
	r0 = r0.x + -r3;
	r0 = abs(r0) + -0.05;
	r0 = (r0 >= 0) ? 1 : 0;
	r0.x = dot(r0, 1);
	r0 = r0.x + -0.01;
	clip(r0);
	o = 0;

	return o;
}
