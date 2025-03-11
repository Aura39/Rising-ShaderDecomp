sampler g_Sampler0 : register(s0);
float g_add_alpha : register(c184);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float2 r1;
	r0 = tex2D(g_Sampler0, texcoord);
	r0.x = dot(r0.xyz, 0.298912);
	r0.y = r0.x * g_add_alpha.x;
	r0.x = r0.x + -0.5;
	r0.y = r0.y * 0.5;
	r1.xy = float2(0.25, 0.75);
	r1.xy = r1.xy * g_add_alpha.xx;
	r0.z = r0.x * r1.y + r1.x;
	r0.x = (r0.x >= 0) ? r0.z : r0.y;
	r0.x = r0.w + r0.x;
	o = r0.x;

	return o;
}
