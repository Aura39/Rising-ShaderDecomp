sampler g_Sampler0;

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	r0 = float4(0.00390625, 0, 0, 0.00390625) + texcoord.xyxy;
	r1 = tex2D(g_Sampler0, r0);
	r0 = tex2D(g_Sampler0, r0.zwzw);
	r2 = float4(-0.00390625, 0, 0, -0.00390625) + texcoord.xyxy;
	r3 = tex2D(g_Sampler0, r2);
	r2 = tex2D(g_Sampler0, r2.zwzw);
	r0.x = -r0.x + r2.x;
	o.y = r0.x * 0.5 + 0.5;
	r0.x = -r1.x + r3.x;
	o.x = r0.x * 0.5 + 0.5;
	r0 = tex2D(g_Sampler0, texcoord);
	o.w = r0.x * 0.5 + 0.5;
	o.z = 1;

	return o;
}
